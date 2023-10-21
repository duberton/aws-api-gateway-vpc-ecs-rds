package com.duberton.api.gw.application.usecase

import com.duberton.api.gw.application.domain.Band
import com.duberton.api.gw.application.port.output.BandRepositoryPort
import com.duberton.api.gw.application.port.output.SaveBandPort

class SaveBandUseCase(private val bandRepositoryPort: BandRepositoryPort) : SaveBandPort {

    override fun save(band: Band): Band {
        return bandRepositoryPort.save(band)
    }
}