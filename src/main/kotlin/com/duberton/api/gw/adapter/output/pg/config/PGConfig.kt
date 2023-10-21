package com.duberton.api.gw.adapter.output.pg.config

import com.duberton.api.gw.adapter.output.pg.BandRepository
import com.duberton.api.gw.adapter.output.pg.jdbc.BandRepositoryJdbc
import org.postgresql.ds.PGSimpleDataSource
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
class PGConfig {

    @Value("\${pg.db.url}")
    private lateinit var url: String

    @Value("\${pg.db.user}")
    private lateinit var user: String

    @Value("\${pg.db.password}")
    private lateinit var password: String

    @Bean
    fun pg(): PGSimpleDataSource {
        val database = PGSimpleDataSource();
        database.setUrl(url)
        database.user = user
        database.password = password
        return database
    }

    @Bean
    fun bandRepository(bandRepositoryJdbc: BandRepositoryJdbc) = BandRepository(bandRepositoryJdbc)

}