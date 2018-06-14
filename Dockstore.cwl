baseCommand: []
class: CommandLineTool
cwlVersion: v1.0
id: soapdenovo-demo
inputs:
  asm_flags:
    default: 3
    doc: ''
    inputBinding:
      position: 8
      prefix: --asm_flags
    type: long
  avg_insert:
    default: 200
    doc: ''
    inputBinding:
      position: 6
      prefix: --avg_insert
    type: long
  k_mer:
    default: 63
    doc: ''
    inputBinding:
      position: 3
      prefix: --k_mer
    type: long
  map_align_len:
    default: 32
    doc: ''
    inputBinding:
      position: 12
      prefix: --map_align_len
    type: long
  pair_number_cutoff:
    default: 3
    doc: ''
    inputBinding:
      position: 11
      prefix: --pair_number_cutoff
    type: long
  prefix:
    default: Demo
    doc: ''
    inputBinding:
      position: 4
      prefix: --prefix
    type: string
  rank:
    default: 1
    doc: ''
    inputBinding:
      position: 10
      prefix: --rank
    type: long
  read:
    doc: Single read or Paired-End read 1
    inputBinding:
      position: 1
      prefix: --read
    type: File
  read_2:
    doc: Paired-End read 2 if have
    inputBinding:
      position: 2
      prefix: --read_2
    type: File?
  read_cutoff:
    default: 100
    doc: 'better to be consistent with read_length; default: 100'
    inputBinding:
      position: 9
      prefix: --read_cutoff
    type: long
  read_length:
    default: 100
    doc: ''
    inputBinding:
      position: 5
      prefix: --read_length
    type: long
  rev_seq:
    default: 0
    doc: '0 means no; 1 means yes. default: 0'
    inputBinding:
      position: 7
      prefix: --rev_seq
    type: long
label: SOAPdenovo demo
outputs:
  all_result:
    doc: ''
    outputBinding:
      glob: all_result/*
    type: File
  contig_output:
    doc: ''
    outputBinding:
      glob: contig_output/*
    type: File
  scaffold_output:
    doc: ''
    outputBinding:
      glob: scaffold_output/*
    type: File
requirements:
- class: DockerRequirement
  dockerOutputDirectory: /data/out
  dockerPull: pfda2dockstore/soapdenovo-demo:15
s:author:
  class: s:Person
  s:name: Leihong Wu
