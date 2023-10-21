package com.duberton.api.gw.adapter.input.api.ext

import com.duberton.api.gw.adapter.input.api.request.BandRequest
import com.duberton.api.gw.adapter.input.api.response.BandResponse
import com.duberton.api.gw.application.domain.Band

fun BandRequest.toDomain() = Band(
    name = name, genre = genre, members = members
)

fun Band.toResponse() = BandResponse(
    id = id, name = name, genre = genre, members = members, createdAt = createdAt
)