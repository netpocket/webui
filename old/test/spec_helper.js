//= require sinon
//= require sinon-chai
sinon.stub(Primus, 'connect');

$ = sinon.stub();

// set the Mocha test interface
// see http://visionmedia.github.com/mocha/#interfaces
mocha.ui('bdd');

// ignore the following globals during leak detection
// mocha.globals(['YUI']);

// or, ignore all leaks
// mocha.ignoreLeaks();

// set slow test timeout in ms
// mocha.timeout(5);

// Show stack trace on failing assertion.
chai.Assertion.includeStack = true;

chai.Assertion.addMethod('write', function(){
  var obj = this._obj;
  var args = Array.prototype.slice.call(arguments, 0);
  this.assert(
    _.isEqual(obj.write.getCall(obj.write.callCount-1).args[0].args, args),
    "expected to write #{exp}, but wrote #{act}",
    "expected not to write #{act}",
    args,
    obj.write.getCall(0).args[0].args,
    true
  );
});

chai.Assertion.addProperty('writeOnce', function(){
  var act = this._obj.write.callCount;
  var exp = 1;
  this.assert(
    act === exp,
    "expected to write #{exp} times but wrote #{act} times",
    "expected not to write #{exp} time",
    exp,
    act
  );
});
