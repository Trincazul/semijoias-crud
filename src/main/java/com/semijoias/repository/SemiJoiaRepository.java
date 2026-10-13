package com.semijoias.repository;

import com.semijoias.model.SemiJoia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SemiJoiaRepository extends JpaRepository<SemiJoia, Long> {

    List<SemiJoia> findByTipoIgnoreCase(String tipo);

    List<SemiJoia> findByMaterialContainingIgnoreCase(String material);

    List<SemiJoia> findByDisponivelTrue();
}