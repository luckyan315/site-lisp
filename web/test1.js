
// node server使用的host和port
HOST = null; // localhost
PORT = 8001;
// when the daemon started
var starttime = (new Date()).getTime();
// 通过memoryUsage每10秒中获得一次内存使用情况
var mem = process.memoryUsage();
// every 10 seconds poll for the memory.
setInterval(function () {
  mem = process.memoryUsage();
}, 10*1000);
/**
 * server.js将使用的nodejs module，其中fu是我们自己定义的
 * 所以require的使用前面有一个"./"
 */
var fu = require("./fu"),
    sys = require("sys"),
    url = require("url"),
    qs = require("querystring");
/** 
 * 为messages和sessions设定的阈值，在使用它们的地方我会再提及它们
 */
var MESSAGE_BACKLOG = 200,
    SESSION_TIMEOUT = 60 * 1000;
/**
 * channel的定义主要包含四个部分：
 *
 * messages和callbacks数组，messages就是用来存放消息的，每个element是
 * json对象，如下面定义的m；而callbacks数组是用来存放暂时不能满足请求
 * 的回调函数，也就是说它们会推迟执行
 * 
 * appendMessage就是用来构造message，然后将它push到messages数组中，而起
 * 它会通过一个while循环去执行callbacks数组里面的回调函数，通过它们将这个消
 * 息发送出去，另外它会检查messages数组中存放的消息数量是否超过了阈值(MESSAGE_BACKLOG)
 * 如果超过就从头开始扔掉一些老的message，只到恢复正常的阈值范围之内。
 *
 * query主要从messages数组中查询某个时间段内的所有message，如果查找到了就会
 * 立即执行callback函数，否则就不得不把callback包装成JSON对象丢入callbacks中，
 * 等待机会来的时候去执行
 * 
 * 对于那些在callbacks数组中存放了太久的callback我们会定期清除它们，因为
 * 这些callback很可能已经是垃圾callback了，没有必要去执行它们了。
 */
var channel = new function () {
  var messages = [],
      callbacks = [];
  this.appendMessage = function (nick, type, text) {
    var m = { nick: nick
            , type: type // "msg", "join", "part"
            , text: text
            , timestamp: (new Date()).getTime()
            };
    switch (type) {
      case "msg":
        sys.puts("<" + nick + "> " + text);
        break;
      case "join":
        sys.puts(nick + " join");
        break;
      case "part":
        sys.puts(nick + " part");
        break;
    }
    messages.push( m );
    while (callbacks.length > 0) {
      callbacks.shift().callback([m]);
    }
    while (messages.length > MESSAGE_BACKLOG)
      messages.shift();
  };
  this.query = function (since, callback) {
    var matching = [];
    for (var i = 0; i < messages.length; i++) {
      var message = messages[i];
      if (message.timestamp > since)
        matching.push(message)
    }
    if (matching.length != 0) {
      callback(matching);
    } else {
      callbacks.push({ timestamp: new Date(), callback: callback });
    }
  };
  // clear old callbacks
  // they can hang around for at most 30 seconds.
  setInterval(function () {
    var now = new Date();
    while (callbacks.length > 0 && now - callbacks[0].timestamp > 30*1000) {
      callbacks.shift().callback([]);
    }
  }, 3000);
};
/**
 * 下面就是session方面的管理，这里是用过一个sessions列表管理的
 *  
 * 在createSession里面会根据一些条件判断是否需要创建新的session
 * 而每个session对象由下面几个部分组成的：
 * nick, id, timestamp属性, poke方法就是用来更新timestamp的，而
 * destory是用来销毁一个session，会通过appendMessage发送一个part
 * 消息出去
 *
 */
var sessions = {};
function createSession (nick) {
  if (nick.length > 50) return null;
  if (/[^/w_/-^!]/.exec(nick)) return null;
  for (var i in sessions) {
    var session = sessions[i];
    if (session && session.nick === nick) return null;
  }
  var session = { 
    nick: nick, 
    id: Math.floor(Math.random()*99999999999).toString(),
    timestamp: new Date(),
    poke: function () {
      session.timestamp = new Date();
    },
    destroy: function () {
      channel.appendMessage(session.nick, "part");
      delete sessions[session.id];
    }
  };
  sessions[session.id] = session;
  return session;
}
/** 
 * 就像清除callback类似，我们也会定期清除一些过期的session
 * 主要这里会遍历sessions中的所有session对象，而不能像处理
 * callback那样，当遇到不满足条件的时候就结束了，因为session
 * 会有可能会更新timestamp，而callbacks中的所以callback可以
 * 是按照timestamp排序了的，所以它可以提前终止后面的判断
 */
// interval to kill off old sessions
setInterval(function () {
  var now = new Date();
  for (var id in sessions) {
    if (!sessions.hasOwnProperty(id)) continue;
    var session = sessions[id];
    if (now - session.timestamp > SESSION_TIMEOUT) {
      session.destroy();
    }
  }
}, 1000);
// server开始监听了，HOST + PORT
fu.listen(Number(process.env.PORT || PORT), HOST);
/**
 * 下面这些代码都是route信息，就是对于给定路径调用相应的handler
 * 其中对于"/", "/style.css", "/client.js", "/jquery-1.2.6.min.js"
 * 都是要在客户端使用或者执行的，是一些固定的东西，统一由staticHandler
 * 来处理 
 */
fu.get("/", fu.staticHandler("index.html"));
fu.get("/style.css", fu.staticHandler("style.css"));
fu.get("/client.js", fu.staticHandler("client.js"));
fu.get("/jquery-1.2.6.min.js", fu.staticHandler("jquery-1.2.6.min.js"));
/**
 * 下面这些get需要结合客户端进行讲解，所以我在后面结合client.js来分析
 * 逻辑处理过程，也就是谁触发了这个url
 * 
 * 从代码层次我先介绍每个get对相应路径做了些什么事情
 */
/**
 * 查看当前的nicks，只要到sessions取出所有的nicks，通过
 * simpleJSON发送给client
 */
fu.get("/who", function (req, res) {
  var nicks = [];
  for (var id in sessions) {
    if (!sessions.hasOwnProperty(id)) continue;
    var session = sessions[id];
    nicks.push(session.nick);
  }
  res.simpleJSON(200, { nicks: nicks
                      , rss: mem.rss
                      });
});
/**
 * 对于join请求，首先要通过createSession为其创建一个session
 * 然后通过chanel的appendMessage发送一个join消息，最后再使用
 * simpleJSON把一些结果(id, nick, rss, starttime)发送给客户端
 * 
 * qs.parse(url.parse(req.url).query)其实做了两件事情，一个是
 * 从url中得到query部分的字符串，然后交给querystring去解析返回
 * 一个JSON object
 * 
 * 发送给client的消息是通过res.simpleJSON发送的
 * 
 * 后面对于的代码分析，parse和simleJSON就不再提及了，你懂的
 */
fu.get("/join", function (req, res) {
  var nick = qs.parse(url.parse(req.url).query).nick;
  if (nick == null || nick.length == 0) {
    res.simpleJSON(400, {error: "Bad nick."});
    return;
  }
  var session = createSession(nick);
  if (session == null) {
    res.simpleJSON(400, {error: "Nick in use"});
    return;
  }
  //sys.puts("connection: " + nick + "@" + res.connection.remoteAddress);
  channel.appendMessage(session.nick, "join");
  res.simpleJSON(200, { id: session.id
                      , nick: session.nick
                      , rss: mem.rss
                      , starttime: starttime
                      });
});
// 对于part请求，需要根据id得到其对应的session，将其从sessions清除
fu.get("/part", function (req, res) {
  var id = qs.parse(url.parse(req.url).query).id;
  var session;
  if (id && sessions[id]) {
    session = sessions[id];
    session.destroy();
  }
  res.simpleJSON(200, { rss: mem.rss });
});
/**
 * 对于recv请求，url query中的since不能为空，否则下面的事情不干
 * 
 * 根据id更新其对应session的timestamp
 * 根据since到channel中查找满足条件的messages，然后发送给client
 *
 */
fu.get("/recv", function (req, res) {
  if (!qs.parse(url.parse(req.url).query).since) {
    res.simpleJSON(400, { error: "Must supply since parameter" });
    return;
  }
  var id = qs.parse(url.parse(req.url).query).id;
  var session;
  if (id && sessions[id]) {
    session = sessions[id];
    session.poke();
  }
  var since = parseInt(qs.parse(url.parse(req.url).query).since, 10);
  channel.query(since, function (messages) {
    if (session) session.poke();
    res.simpleJSON(200, { messages: messages, rss: mem.rss });
  });
});
/**
 * 对于send请求，client发来了消息，所以更细其session的timestamp，然后
 * 将这个消息放到channel的messages数组中(appendMessage)
 */
fu.get("/send", function (req, res) {
  var id = qs.parse(url.parse(req.url).query).id;
  var text = qs.parse(url.parse(req.url).query).text;
  var session = sessions[id];
  if (!session || !text) {
    res.simpleJSON(400, { error: "No such session id" });
    return;
  }
  session.poke();
  channel.appendMessage(session.nick, "msg", text);
  res.simpleJSON(200, { rss: mem.rss });
});