# global describe, beforeEach, assert, it
"use strict"

describe 'Device Model', ->
  beforeEach ->
    @Device = new nccWebui.Models.DeviceModel()

  describe "useFeature", ->
    beforeEach ->
      nccWebui.connection =
        socket: socketStub()
        emit: sinon.stub()
      @cbSpy = sinon.stub()
      @Device.useFeature('name:spa:cing', @cbSpy)

    it "registers a one-time listener", ->

    it "sends the feature request", ->
