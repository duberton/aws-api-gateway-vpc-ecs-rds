package com.duberton.api.gw.application.domain

import java.time.LocalDateTime

data class Band(
    val id: String? = null,
    val name: String,
    val genre: String,
    val members: List<String>,
    val createdAt: String = LocalDateTime.now().toString()
)