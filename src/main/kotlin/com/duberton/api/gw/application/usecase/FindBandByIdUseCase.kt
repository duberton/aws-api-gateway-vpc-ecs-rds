package com.duberton.api.gw.application.usecase

import com.duberton.api.gw.adapter.input.api.controller.exception.NotFoundException
import com.duberton.api.gw.application.port.output.BandRepositoryPort
import com.duberton.api.gw.application.port.output.FindBandByIdPort

class FindBandByIdUseCase(private val bandRepositoryPort: BandRepositoryPort) : FindBandByIdPort {

    override fun execute(id: String) = bandRepositoryPort.findById(id) ?: throw NotFoundException(id)

}