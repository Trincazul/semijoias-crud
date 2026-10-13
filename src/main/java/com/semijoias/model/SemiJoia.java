package com.semijoias.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;

@Entity
@Table(name = "semijoias")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SemiJoia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "O nome e obrigatorio")
    @Size(max = 100, message = "O nome pode ter no maximo 100 caracteres")
    @Column(nullable = false, length = 100)
    private String nome;

    @NotBlank(message = "O tipo e obrigatorio (ex.: anel, colar, brinco)")
    @Size(max = 50, message = "O tipo pode ter no maximo 50 caracteres")
    @Column(nullable = false, length = 50)
    private String tipo;

    @NotBlank(message = "O material e obrigatorio (ex.: banhado a ouro, prata)")
    @Size(max = 80, message = "O material pode ter no maximo 80 caracteres")
    @Column(nullable = false, length = 80)
    private String material;

    @NotNull(message = "O preco e obrigatorio")
    @DecimalMin(value = "0.0", inclusive = false, message = "O preco deve ser maior que zero")
    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal preco;

    @NotNull(message = "O peso e obrigatorio (em gramas)")
    @Positive(message = "O peso deve ser positivo")
    @Column(nullable = false)
    private Double pesoGramas;

    @Size(max = 200, message = "A descricao pode ter no maximo 200 caracteres")
    @Column(length = 200)
    private String descricao;

    @Column(nullable = false)
    @Builder.Default
    private boolean disponivel = true;
}