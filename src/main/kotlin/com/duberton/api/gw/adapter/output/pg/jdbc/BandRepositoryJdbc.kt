package com.duberton.api.gw.adapter.output.pg.jdbc

import com.duberton.api.gw.adapter.output.pg.entity.BandEntity
import org.springframework.data.repository.CrudRepository
import org.springframework.data.repository.PagingAndSortingRepository
import org.springframework.stereotype.Repository

@Repository
interface BandRepositoryJdbc : CrudRepository<BandEntity, String>, PagingAndSortingRepository<BandEntity, String>