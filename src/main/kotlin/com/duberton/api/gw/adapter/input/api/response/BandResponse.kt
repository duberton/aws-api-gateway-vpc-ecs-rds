package com.duberton.api.gw.adapter.input.api.response

data class BandResponse(
    val id: String?,
    val name: String,
    val genre: String,
    val members: List<String>,
    val createdAt: String
)