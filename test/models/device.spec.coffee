describe 'Device Model', ->
  beforeEach ->
    @Device = new nccWebui.Models.DeviceModel({id:2})

  describe "useFeature", ->
    conn = null
    beforeEach ->
      conn = nccWebui.connection =
        socket: sparkStub()
        emit: sinon.stub()
      @cbSpy = sinon.stub()
      @Device.useFeature('os:get:uptime', @cbSpy)

    it "registers a one-time listener for the response", ->
      expect(conn.socket).to.listenOnce('device:2')

    describe "feature request", ->
      beforeEach ->
        @req = conn.emit.getCall(0).args[1]

      it "tells the relay which device this is", ->
        expect(conn.emit).to.have.been.calledWith 'device:2'

      it "tells the relay that it will listen once", ->
        expect(@req.listen).to.eq "once"

      it 'tells the relay this is a feature request', ->
        expect(@req.cmd).to.eq 'feature request'

      it 'tells the relay which feature', ->
        expect(@req.args).to.deep.eq [ 'os', 'get', 'uptime' ]
