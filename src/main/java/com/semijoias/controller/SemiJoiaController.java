package com.semijoias.controller;

import com.semijoias.model.SemiJoia;
import com.semijoias.service.SemiJoiaService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/semijoias")
@RequiredArgsConstructor
public class SemiJoiaController {

    private final SemiJoiaService service;

    @GetMapping
    public ResponseEntity<List<SemiJoia>> listarTodas() {
        return ResponseEntity.ok(service.listarTodas());
    }

    @GetMapping("/{id}")
    public ResponseEntity<SemiJoia> buscarPorId(@PathVariable Long id) {
        return ResponseEntity.ok(service.buscarPorId(id));
    }

    @GetMapping("/tipo/{tipo}")
    public ResponseEntity<List<SemiJoia>> buscarPorTipo(@PathVariable String tipo) {
        return ResponseEntity.ok(service.buscarPorTipo(tipo));
    }

    @GetMapping("/material/{material}")
    public ResponseEntity<List<SemiJoia>> buscarPorMaterial(@PathVariable String material) {
        return ResponseEntity.ok(service.buscarPorMaterial(material));
    }

    @GetMapping("/disponiveis")
    public ResponseEntity<List<SemiJoia>> listarDisponiveis() {
        return ResponseEntity.ok(service.listarDisponiveis());
    }

    @PostMapping
    public ResponseEntity<SemiJoia> criar(@Valid @RequestBody SemiJoia semijoia) {
        SemiJoia criada = service.criar(semijoia);
        return ResponseEntity.status(HttpStatus.CREATED).body(criada);
    }

    @PutMapping("/{id}")
    public ResponseEntity<SemiJoia> atualizar(@PathVariable Long id, @Valid @RequestBody SemiJoia semijoia) {
        return ResponseEntity.ok(service.atualizar(id, semijoia));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletar(@PathVariable Long id) {
        service.deletar(id);
        return ResponseEntity.noContent().build();
    }
}