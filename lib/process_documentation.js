(function() {
  var ProcessDocumentation, fileUtils, mParser, poolParser, _;

  mParser = require('./modelerParser');

  fileUtils = require('./fileUtils');

  poolParser = require('./poolParser');

  _ = require('lodash');

  ProcessDocumentation = (function() {
    function ProcessDocumentation(processData) {
      this.data = processData;
    }

    ProcessDocumentation.prototype.parseFiles = function(path, callback) {
      return fileUtils.getProcessFiles(path, (function(_this) {
        return function(err, data) {
          if (err) {
            callback(err);
          }
          _this.data = data;
          return _this.parse(callback);
        };
      })(this));
    };

    ProcessDocumentation.prototype.parse = function(callback) {
      var modeler, modelerParser;
      if (!this.data) {
        callback("Process data not available");
      }
      modeler = _.find(this.data, function(item) {
        return item.file === "modeler.bpmn";
      });
      if (!modeler) {
        callback("modeler.bpmn not found");
      }
      modelerParser = new mParser(modeler.data);
      return modelerParser.parse((function(_this) {
        return function(parsedPools) {
          _this.pools = parsedPools;
          return _this.parsePools(callback);
        };
      })(this));
    };

    ProcessDocumentation.prototype.parsePools = function(cb) {
      var done;
      done = _.after(this.pools.length, function(data) {
        return cb(null, data);
      });
      return _.each(this.pools, (function(_this) {
        return function(pool) {
          var parser, poolData;
          poolData = _.find(_this.data, function(item) {
            return item.file === pool.id + ".bpdm";
          });
          parser = new poolParser(pool, poolData.data);
          return parser.parse(cb, done);
        };
      })(this));
    };

    return ProcessDocumentation;

  })();

  module.exports = ProcessDocumentation;

}).call(this);
