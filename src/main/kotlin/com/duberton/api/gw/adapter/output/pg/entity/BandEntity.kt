package com.duberton.api.gw.adapter.output.pg.entity

import org.springframework.data.annotation.Id
import org.springframework.data.relational.core.mapping.Table
import java.time.LocalDateTime
import java.util.*
import javax.persistence.GeneratedValue

@Table("band")
class BandEntity(
    @Id @GeneratedValue var id: UUID? = null,
    val name: String,
    val genre: String,
    val members: List<String>,
    val createdAt: LocalDateTime
)