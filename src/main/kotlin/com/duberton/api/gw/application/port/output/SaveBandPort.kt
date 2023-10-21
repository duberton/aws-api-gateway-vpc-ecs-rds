package com.duberton.api.gw.application.port.output

import com.duberton.api.gw.application.domain.Band

interface SaveBandPort {

    fun save(band: Band): Band

}