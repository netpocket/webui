# global describe, beforeEach, assert, it
"use strict"

describe 'Device View', ->
  beforeEach ->
    @Device = new nccWebui.Views.DeviceView();
