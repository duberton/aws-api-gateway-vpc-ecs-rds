package com.duberton.api.gw.application.port.output

import com.duberton.api.gw.application.domain.Band

interface FindBandByIdPort {

    fun execute(id: String): Band?

}