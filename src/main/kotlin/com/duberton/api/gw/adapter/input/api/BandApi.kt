package com.duberton.api.gw.adapter.input.api

import com.duberton.api.gw.adapter.input.api.request.BandRequest
import com.duberton.api.gw.adapter.input.api.response.BandResponse
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*

@RequestMapping("/v1/bands")
interface BandApi {

    @PostMapping
    @ResponseStatus(HttpStatus.OK)
    fun createBand(@RequestBody request: BandRequest): BandResponse

    @GetMapping
    @ResponseStatus(HttpStatus.OK)
    fun bands(
        @RequestParam("offset", required = false, defaultValue = "0") offset: Int,
        @RequestParam("page", required = false, defaultValue = "10") page: Int
    ): List<BandResponse>

    @GetMapping("/{bandId}")
    @ResponseStatus(HttpStatus.OK)
    fun band(@PathVariable("bandId") bandId: String): BandResponse?

    @DeleteMapping("/{bandId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    fun deleteBand(@PathVariable("bandId") bandId: String)
}