package com.duberton.api.gw.application.port.output

import com.duberton.api.gw.application.domain.Band

interface FindBandsPort {

    fun execute(offset: Int, page: Int): List<Band>

}