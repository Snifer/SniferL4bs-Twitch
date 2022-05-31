---

database-plugin: basic

---
<%%
name: undefined
description: undefined
columns:
  VmName:
    input: text
    accessor: VmName
    label: Maquina
    key: VmName
    position: 1
  Desarrolador:
    input: select
    accessor: Creator
    label: Creador
    key: Creator
    position: 2
  Link:
    input: text
    accessor: Link
    key: Link
    label: Link
    position: 3
  Completed:
    input: select
    accessor: Completado
    key: Completado
    label: Resuelto
    position: 4
  Level:
    input: select
    accessor: Level
    label: Nivel
    key: Level
    position: 5
  Plataforma:
    input: select
    accessor: Plataforma
    key: Plataforma
    label: Plataforma
    position: 6
  Release:
    input: text
    accessor: Release
    key: Release
    label: Release
    position: 7
config:
  enable_show_state: false
%%>