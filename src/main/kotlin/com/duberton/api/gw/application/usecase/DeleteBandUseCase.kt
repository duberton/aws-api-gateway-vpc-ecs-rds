package com.duberton.api.gw.application.usecase

import com.duberton.api.gw.adapter.input.api.controller.exception.NotFoundException
import com.duberton.api.gw.application.port.output.BandRepositoryPort
import com.duberton.api.gw.application.port.output.DeleteBandPort

class DeleteBandUseCase(private val bandRepositoryPort: BandRepositoryPort) : DeleteBandPort {

    override fun execute(id: String) = when (bandRepositoryPort.existsById(id)) {
        true -> bandRepositoryPort.delete(id)
        else -> throw NotFoundException(id)
    }
}