# global describe, beforeEach, assert, it
"use strict"

describe 'Device Model', ->
  beforeEach ->
    @Device = new nccWebui.Models.DeviceModel()

  describe "useFeature", ->
    conn = null
    beforeEach ->
      conn = nccWebui.connection =
        socket: sparkStub()
        emit: sinon.stub()
      @cbSpy = sinon.stub()
      @Device.useFeature('name:spa:cing', @cbSpy)

    it "registers a one-time listener", ->
      expect(conn.socket).to.listenOnce('device:1')


    it "sends the feature request", ->
