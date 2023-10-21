package com.duberton.api.gw.adapter.output.pg

import com.duberton.api.gw.adapter.output.pg.ext.toDomain
import com.duberton.api.gw.adapter.output.pg.ext.toEntity
import com.duberton.api.gw.adapter.output.pg.jdbc.BandRepositoryJdbc
import com.duberton.api.gw.application.domain.Band
import com.duberton.api.gw.application.port.output.BandRepositoryPort
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
import kotlin.jvm.optionals.getOrNull


class BandRepository(private val bandRepositoryJdbc: BandRepositoryJdbc) : BandRepositoryPort {

    override fun save(band: Band) = bandRepositoryJdbc.save(band.toEntity()).toDomain()
    override fun existsById(id: String) = bandRepositoryJdbc.existsById(id)

    override fun findById(id: String) = bandRepositoryJdbc.findById(id).getOrNull()?.toDomain()

    override fun findAll(offset: Int, page: Int) = bandRepositoryJdbc.findAll(
        PageRequest.of(
            offset, page, Sort.by(Sort.Direction.ASC, "createdAt")
        )
    ).content.map { it.toDomain() }

    override fun delete(id: String) = bandRepositoryJdbc.deleteById(id)
}