package com.semijoias.service;

import com.semijoias.exception.ResourceNotFoundException;
import com.semijoias.model.SemiJoia;
import com.semijoias.repository.SemiJoiaRepository;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SemiJoiaService {

    private final SemiJoiaRepository repository;

    public List<SemiJoia> listarTodas() {
        return repository.findAll();
    }

    public SemiJoia buscarPorId(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Semijoia com id " + id + " nao encontrada"));
    }

    public List<SemiJoia> buscarPorTipo(String tipo) {
        return repository.findByTipoIgnoreCase(tipo);
    }

    public List<SemiJoia> buscarPorMaterial(String material) {
        return repository.findByMaterialContainingIgnoreCase(material);
    }

    public List<SemiJoia> listarDisponiveis() {
        return repository.findByDisponivelTrue();
    }

    public SemiJoia criar(@Valid SemiJoia semijoia) {
        semijoia.setId(null); // garante insert
        return repository.save(semijoia);
    }

    public SemiJoia atualizar(Long id, @Valid SemiJoia dados) {
        SemiJoia existente = buscarPorId(id);
        existente.setNome(dados.getNome());
        existente.setTipo(dados.getTipo());
        existente.setMaterial(dados.getMaterial());
        existente.setPreco(dados.getPreco());
        existente.setPesoGramas(dados.getPesoGramas());
        existente.setDescricao(dados.getDescricao());
        existente.setDisponivel(dados.isDisponivel());
        return repository.save(existente);
    }

    public void deletar(Long id) {
        if (!repository.existsById(id)) {
            throw new ResourceNotFoundException("Semijoia com id " + id + " nao encontrada");
        }
        repository.deleteById(id);
    }
}