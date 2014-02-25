# global describe, beforeEach, assert, it
"use strict"

describe 'Device Model', ->
  beforeEach ->
    @Device = new nccWebui.Models.DeviceModel();
