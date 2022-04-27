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
    input: text
    accessor: Creator
    label: Desarrollador
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
    position: 5
  Level:
    input: select
    accessor: Level
    label: Nivel
    key: Level
    position: 5
config:
  enable_show_state: false
%%>