package com.duberton.api.gw.application.port.output

import com.duberton.api.gw.application.domain.Band

interface BandRepositoryPort {

    fun save(band: Band): Band

    fun existsById(id: String): Boolean

    fun findById(id: String): Band?

    fun findAll(offset: Int, page: Int): List<Band>

    fun delete(id: String)

}