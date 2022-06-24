import Redis from "ioredis";

var redis = new Redis(); // todo: add convar support for custom server params

global.onNet("wtf_redis:call", async (ev, id, cmd, args) => {
  let source = global.source;
  const sendResponse = (res, err) => {
    setImmediate(() =>
      global.TriggerClientEvent(ev, source, id, err || false, res)
    );
  };
  try {
    const res = await redis[cmd](...args);
    sendResponse(res, null);
  } catch (err) {
    sendResponse(null, err);
  }
});
