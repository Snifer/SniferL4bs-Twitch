<!-- slide bg="https://sniferl4bs.com/images/whoami/avatar.jpg" data-background-opacity="0.09"  -->
# APRENDIENDO MARKDOWN
> Jose Moruno Cadima - Snifer
> https://www.sniferl4bs.com

--


<!-- slide bg="https://e7.pngegg.com/pngimages/173/882/png-clipart-logo-markdown-wikimedia-movement-scalable-graphics-brand-markdowns-white-text-thumbnail.png" data-background-opacity="0.09"  -->

> [!NOTE]-¿Que es  Markdown?
> [Markdown](https://es.wikipedia.org/wiki/Markdown) es una manera de agregar formatos como encabezados, **negritas**, *cursivas*, listas… a un texto sin formato. 

--

- Se creó como una alternativa a HTML más simple. <!-- element class="fragment" data-fragment-index="1" --> 
- Es un sistema de escritura minimalista. <!-- element class="fragment" data-fragment-index="2" --> 
- Puede ser exportados a otros sitios y formatos con facilidad.<!-- element class="fragment" data-fragment-index="3" --> 

--

> [!important] Importante
> Veremos próximamente la generación de documentos e informes de Pentesting o tareas específicas desde Obsidian con Markdown.

--

#### Markdown 

1. Cabeceras. <!-- element class="fragment" data-fragment-index="1" --> 
2. Estilos de Texto.<!-- element class="fragment" data-fragment-index="2" --> 
3. Listas.<!-- element class="fragment" data-fragment-index="3" --> 
4. Imágenes.<!-- element class="fragment" data-fragment-index="4" --> 
5. Links.<!-- element class="fragment" data-fragment-index="5" --> 
6. Citas.<!-- element class="fragment" data-fragment-index="6" --> 
7. Bloques de Código.<!-- element class="fragment" data-fragment-index="7" --> 
8. Tablas.<!-- element class="fragment" data-fragment-index="8" --> 
9. Footnotes.<!-- element class="fragment" data-fragment-index="9" --> 
10. Avisos. <!-- element class="fragment" data-fragment-index="10" --> 
---

<!-- slide bg="https://sniferl4bs.com/images/whoami/avatar.jpg" data-background-opacity="0.09"  -->
## Headers - Cabeceras


```md
# Nivel 1
## Nivel 2
### Nivel 3 
#### Nivel 4
##### Nivel 5
###### Nivel 6
```

Nos permite contar hasta 6 niveles

--
###  Estilos de texto
- **Negrita** <!-- element class="fragment" data-fragment-index="1" --> 
	- `**Negrita**` <!-- element class="fragment" data-fragment-index="1" --> 
- *Cursiva* <!-- element class="fragment" data-fragment-index="2" --> 
	- `_Cursiva_`<!-- element class="fragment" data-fragment-index="2" --> 
- ~~Tachado~~<!-- element class="fragment" data-fragment-index="3" --> 
	- `~~TACHADO~~`<!-- element class="fragment" data-fragment-index="3" --> 
- ==RESALTADO==<!-- element class="fragment" data-fragment-index="4" --> 
	- ```==RESALTADO==```<!-- element class="fragment" data-fragment-index="4" --> 
--
<!-- slide bg="https://sniferl4bs.com/images/whoami/avatar.jpg" data-background-opacity="0.09"  -->
### <mark style="background: #FFF3A3A6;">Listas</mark> 
- Suscríbete
	- YouTube 
- Síguenos:
	- Twitch **SniferL4bs**
	- Twitter  *@sniferl4bs*

```md
- Suscríbete
	- YouTube 
- Síguenos:
	- Twitch **SniferL4bs**
	- Twitter  *@sniferl4bs*
```
--
### <mark style="background: #FFF3A3A6;">Listas</mark> 
1. Suscríbete
	1. YouTube 
2. Síguenos:
	1. Twitch **SniferL4bs**
	3. Twitter  *@sniferl4bs*

```md
1. Suscríbete
	1. YouTube 
2. Síguenos:
	1. Twitch **SniferL4bs**
	3. Twitter  *@sniferl4bs*
```

--
### Imagenes
<!-- slide bg="https://sniferl4bs.com/images/whoami/avatar.jpg" data-background-opacity="0.09"  -->

> Markdown tradicional

```md
\![Image](https://picsum.photos/id/100/500/300)
```

![Image](https://picsum.photos/id/100/500/300)

--
### Imagenes
<!-- slide bg="https://sniferl4bs.com/images/whoami/avatar.jpg" data-background-opacity="0.09"  -->
> Sintaxis de Obsidian

![[Pasted image 20220528203510.png|400]]

![[blackhat.png|200]]

--

### Links
<!-- slide bg="https://sniferl4bs.com/images/whoami/avatar.jpg" data-background-opacity="0.09"  -->


```md

https://sniferl4bs.com - automatico
[Snifer@L4b's](https://sniferl4bs.com)
```

- https://sniferl4bs.com <!-- element class="fragment" data-fragment-index="2" -->  automatico <!-- element class="fragment" data-fragment-index="2" --> 
- [Snifer@L4b's](https://sniferl4bs.com) <!-- element class="fragment" data-fragment-index="3" --> 


--
<!-- slide bg="https://sniferl4bs.com/images/whoami/avatar.jpg" data-background-opacity="0.09"  -->
### Links en Obsidian

![[Pasted image 20220528210603.png|600]]

![[Pasted image 20220528210525.png]]

---

## Incrustaciones
<!-- slide bg="https://sniferl4bs.com/images/whoami/avatar.jpg" data-background-opacity="0.09"  -->
```md
![[Introduccion a Obsidian y Markdown#¿ Qué es Obsidian]]
```
![[Pasted image 20220528210922.png]]

--
<!-- slide bg="https://laestanteriadenuria.files.wordpress.com/2014/08/kvothe_by_zusacre-d5pdz2s.jpg?w=800&h=602&crop=1" data-background-opacity="0.09"  -->
## CITAS
```md
> “Mis mayores éxitos fueron producto de decisiones que tomé cuando dejé de pensar e hice sencillamente lo que me parecía correcto.”
> \-Patrick Rothfus, El nombre del Viento
```
> “Mis mayores éxitos fueron producto de decisiones que tomé cuando dejé de pensar e hice sencillamente lo que me parecía correcto.”
> \-Patrick Rothfus, El nombre del Viento

--

## Bloques de Codigo 
<!-- slide bg="https://blogs.imf-formacion.com/blog/tecnologia/wp-content/uploads/2019/11/python-claves-para-principiantes-812x447.jpg" data-background-opacity="0.09"  -->
- ![[Pasted image 20220528211603.png|500]]
- Inline usando \`backticks`

--

## Tablas
<!-- slide bg="https://sniferl4bs.com/images/whoami/avatar.jpg" data-background-opacity="0.09"  -->

![[Pasted image 20220528212448.png]]

--


| No  | Descripcion | URL                      |
| --- | ----------- | ------------------------ |
| 1   | Sitio web   | www.sniferl4bs.com       |
| 2   | YouTube     | https://youtube.com/c/SniferL4bs |
|     |             |                          |


![[Pasted image 20220528212416.png]]

--

## Footnotes 
<!-- slide bg="https://sniferl4bs.com/images/whoami/avatar.jpg" data-background-opacity="0.09"  -->

![[Pasted image 20220528212834.png|900]]
![[Pasted image 20220528212916.png]]

---

<!-- slide bg="https://sniferl4bs.com/images/whoami/avatar.jpg" data-background-opacity="0.09"  -->
> [!question] ¿Preguntas? 
> Puedes hacerlo en los comentarios en YouTube https://www.youtube.com/c/SniferL4bs, estar presente en los Lives de Twitch. https://twitch.tv/sniferl4bs
> 
<!-- element style="width:90%;font-size:40px" rotate="10"-->
