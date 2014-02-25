# global describe, beforeEach, assert, it
"use strict"

describe 'Device Model', ->
  beforeEach ->
    @Device = new nccWebui.Models.DeviceModel()

  describe "useFeature", ->
    spy = null

    beforeEach ->
      @Device.useFeature('name:spa:cing', spy)

    it "registers a one-time listener", ->


    it "sends the feature request", ->
