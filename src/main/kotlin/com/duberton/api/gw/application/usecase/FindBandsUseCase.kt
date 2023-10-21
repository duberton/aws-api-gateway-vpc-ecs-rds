package com.duberton.api.gw.application.usecase

import com.duberton.api.gw.application.domain.Band
import com.duberton.api.gw.application.port.output.BandRepositoryPort
import com.duberton.api.gw.application.port.output.FindBandsPort

class FindBandsUseCase(private val bandRepositoryPort: BandRepositoryPort) : FindBandsPort {

    override fun execute(offset: Int, page: Int): List<Band> {
        return bandRepositoryPort.findAll(offset, page)
    }

}