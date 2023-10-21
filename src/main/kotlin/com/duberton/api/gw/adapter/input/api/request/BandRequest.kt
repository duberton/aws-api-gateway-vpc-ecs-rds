package com.duberton.api.gw.adapter.input.api.request

data class BandRequest(
    val name: String,
    val genre: String,
    val members: List<String>
)