# Generated by precisionFDA exporter (v1.0.3) on 2018-06-14 03:40:27 +0000
# The asset download links in this file are valid only for 24h.

# Exported app: soapdenovo-demo, revision: 15, authored by: leihong.wu
# https://precision.fda.gov/apps/app-F0VbpK00Zz81pyxzK0zbQjfk

# For more information please consult the app export section in the precisionFDA docs

# Start with Ubuntu 14.04 base image
FROM ubuntu:14.04

# Install default precisionFDA Ubuntu packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
	aria2 \
	byobu \
	cmake \
	cpanminus \
	curl \
	dstat \
	g++ \
	git \
	htop \
	libboost-all-dev \
	libcurl4-openssl-dev \
	libncurses5-dev \
	make \
	perl \
	pypy \
	python-dev \
	python-pip \
	r-base \
	ruby1.9.3 \
	wget \
	xz-utils

# Install default precisionFDA python packages
RUN pip install \
	requests==2.5.0 \
	futures==2.2.0 \
	setuptools==10.2

# Add DNAnexus repo to apt-get
RUN /bin/bash -c "echo 'deb http://dnanexus-apt-prod.s3.amazonaws.com/ubuntu trusty/amd64/' > /etc/apt/sources.list.d/dnanexus.list"
RUN /bin/bash -c "echo 'deb http://dnanexus-apt-prod.s3.amazonaws.com/ubuntu trusty/all/' >> /etc/apt/sources.list.d/dnanexus.list"
RUN curl https://wiki.dnanexus.com/images/files/ubuntu-signing-key.gpg | apt-key add -

# Update apt-get
RUN DEBIAN_FRONTEND=noninteractive apt-get update

# Download app assets
RUN curl https://dl.dnanex.us/F/D/JVV70z23Y375pfP1VfP287VzxbF9x7XY72fqZGXZ/SOAPdenovo2.tar.gz | tar xzf - -C / --no-same-owner --no-same-permissions

# Download helper executables
RUN curl https://dl.dnanex.us/F/D/0K8P4zZvjq9vQ6qV0b6QqY1z2zvfZ0QKQP4gjBXp/emit-1.0.tar.gz | tar xzf - -C /usr/bin/ --no-same-owner --no-same-permissions
RUN curl https://dl.dnanex.us/F/D/bByKQvv1F7BFP3xXPgYXZPZjkXj9V684VPz8gb7p/run-1.2.tar.gz | tar xzf - -C /usr/bin/ --no-same-owner --no-same-permissions

# Write app spec and code to root folder
RUN ["/bin/bash","-c","echo -E \\{\\\"spec\\\":\\{\\\"input_spec\\\":\\[\\{\\\"name\\\":\\\"read\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"Fastq\\ file\\ for\\ Single\\ Read\\\",\\\"help\\\":\\\"Single\\ read\\ or\\ Paired-End\\ read\\ 1\\\"\\},\\{\\\"name\\\":\\\"read_2\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":true,\\\"label\\\":\\\"Fastq\\ file\\ for\\ Paired-end\\ Read\\\",\\\"help\\\":\\\"Paired-End\\ read\\ 2\\ if\\ have\\\"\\},\\{\\\"name\\\":\\\"k_mer\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"K-mer\\ for\\ SOAPdenovo\\ use\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":63\\},\\{\\\"name\\\":\\\"prefix\\\",\\\"class\\\":\\\"string\\\",\\\"optional\\\":false,\\\"label\\\":\\\"\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":\\\"Demo\\\"\\},\\{\\\"name\\\":\\\"read_length\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"maximal\\ read\\ length\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":100\\},\\{\\\"name\\\":\\\"avg_insert\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"average\\ insert\\ size\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":200\\},\\{\\\"name\\\":\\\"rev_seq\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"if\\ sequence\\ needs\\ to\\ be\\ reversed\\\",\\\"help\\\":\\\"0\\ means\\ no\\;\\ 1\\ means\\ yes.\\ default:\\ 0\\\",\\\"default\\\":0\\},\\{\\\"name\\\":\\\"asm_flags\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"In\\ which\\ part\\(s\\)\\ the\\ reads\\ are\\ used\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":3\\},\\{\\\"name\\\":\\\"read_cutoff\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"use\\ only\\ first\\ X\\ bps\\ of\\ each\\ read\\\",\\\"help\\\":\\\"better\\ to\\ be\\ consistent\\ with\\ read_length\\;\\ default:\\ 100\\\",\\\"default\\\":100\\},\\{\\\"name\\\":\\\"rank\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"in\\ which\\ order\\ the\\ reads\\ are\\ used\\ while\\ scaffolding\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":1\\},\\{\\\"name\\\":\\\"pair_number_cutoff\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"cutoff\\ of\\ pair\\ number\\ for\\ a\\ reliable\\ connection\\ \\(at\\ least\\ 3\\ for\\ short\\ insert\\ size\\)\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":3\\},\\{\\\"name\\\":\\\"map_align_len\\\",\\\"class\\\":\\\"int\\\",\\\"optional\\\":false,\\\"label\\\":\\\"minimum\\ aligned\\ length\\ to\\ contigs\\ for\\ a\\ reliable\\ read\\ location\\ \\(at\\ least\\ 32\\ for\\ short\\ insert\\ size\\)\\\",\\\"help\\\":\\\"\\\",\\\"default\\\":32\\}\\],\\\"output_spec\\\":\\[\\{\\\"name\\\":\\\"contig_output\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"should\\ be\\ final\\ contig\\ file\\ \\\",\\\"help\\\":\\\"\\\"\\},\\{\\\"name\\\":\\\"scaffold_output\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"should\\ be\\ final\\ scaffold\\ file\\ \\\",\\\"help\\\":\\\"\\\"\\},\\{\\\"name\\\":\\\"all_result\\\",\\\"class\\\":\\\"file\\\",\\\"optional\\\":false,\\\"label\\\":\\\"tar.gz\\ file\\ of\\ all\\ outputs\\\",\\\"help\\\":\\\"\\\"\\}\\],\\\"internet_access\\\":false,\\\"instance_type\\\":\\\"himem-32\\\"\\},\\\"assets\\\":\\[\\\"file-F00ZKG00Z2fgY0J80JkF2kGJ\\\"\\],\\\"packages\\\":\\[\\]\\} \u003e /spec.json"]
RUN ["/bin/bash","-c","echo -E \\{\\\"code\\\":\\\"\\#\\ Generate\\ a\\ contig\\ files\\ used\\ for\\ SOAP\\ denovo\\\\nrm\\ -f\\ config.txt\\\\necho\\ \\\\\\\"\\#maximal\\ read\\ length\\\\\\\"\\ \\\\u003econfig.txt\\\\necho\\ \\\\\\\"max_rd_len\\=\\\\\\\"\\$read_length\\ \\\\u003e\\\\u003econfig.txt\\\\necho\\ \\\\\\\"\\[LIB\\]\\\\\\\"\\ \\\\u003e\\\\u003econfig.txt\\ \\\\necho\\ \\\\\\\"\\#average\\ insert\\ size\\\\\\\"\\ \\\\u003e\\\\u003econfig.txt\\ \\\\necho\\ \\\\\\\"avg_ins\\=\\\\\\\"\\$avg_insert\\ \\\\u003e\\\\u003econfig.txt\\ \\\\necho\\ \\\\\\\"\\#if\\ sequence\\ needs\\ to\\ be\\ reversed\\\\\\\"\\ \\\\u003e\\\\u003econfig.txt\\ \\\\necho\\ \\\\\\\"reverse_seq\\=\\\\\\\"\\$rev_seq\\ \\\\u003e\\\\u003econfig.txt\\ \\\\necho\\ \\\\\\\"\\#in\\ which\\ part\\(s\\)\\ the\\ reads\\ are\\ used\\\\\\\"\\ \\\\u003e\\\\u003econfig.txt\\ \\\\necho\\ \\\\\\\"asm_flags\\=\\\\\\\"\\$asm_flags\\ \\\\u003e\\\\u003econfig.txt\\ \\\\necho\\ \\\\\\\"\\#use\\ only\\ first\\ 100\\ bps\\ of\\ each\\ read\\\\\\\"\\ \\\\u003e\\\\u003econfig.txt\\ \\\\necho\\ \\\\\\\"rd_len_cutoff\\=\\\\\\\"\\$read_cutoff\\ \\\\u003e\\\\u003econfig.txt\\ \\\\necho\\ \\\\\\\"\\#in\\ which\\ order\\ the\\ reads\\ are\\ used\\ while\\ scaffolding\\\\\\\"\\ \\\\u003e\\\\u003econfig.txt\\ \\\\necho\\ \\\\\\\"rank\\=\\\\\\\"\\$rank\\ \\\\u003e\\\\u003econfig.txt\\ \\\\necho\\ \\\\\\\"\\#\\ cutoff\\ of\\ pair\\ number\\ for\\ a\\ reliable\\ connection\\ \\(at\\ least\\ 3\\ for\\ short\\ insert\\ size\\)\\\\\\\"\\ \\\\u003e\\\\u003econfig.txt\\ \\\\necho\\ \\\\\\\"pair_num_cutoff\\=\\\\\\\"\\$pair_number_cutoff\\ \\\\u003e\\\\u003econfig.txt\\ \\\\necho\\ \\\\\\\"\\#minimum\\ aligned\\ length\\ to\\ contigs\\ for\\ a\\ reliable\\ read\\ location\\ \\(at\\ least\\ 32\\ for\\ short\\ insert\\ size\\)\\\\\\\"\\ \\\\u003e\\\\u003econfig.txt\\ \\\\necho\\ \\\\\\\"map_len\\=\\\\\\\"\\$map_align_len\\ \\\\u003e\\\\u003econfig.txt\\ \\\\n\\\\n\\#\\ Single\\ or\\ Paired-end\\ Reads\\ input\\ files\\\\nif\\ \\[\\ -z\\ \\$\\{read_2\\+x\\}\\ \\]\\\\nthen\\\\n\\ \\ echo\\ \\\\\\\"\\#a\\ pair\\ of\\ fastq\\ file,\\ read\\ 1\\ file\\ should\\ always\\ be\\ followed\\ by\\ read\\ 2\\ file\\\\\\\"\\ \\\\u003e\\\\u003econfig.txt\\\\n\\ \\ echo\\ \\\\\\\"q\\=\\\\\\\"\\$read_path\\ \\\\u003e\\\\u003econfig.txt\\ \\\\nelse\\\\n\\ \\ echo\\ \\\\\\\"\\#fastq\\ file\\ for\\ single\\ reads\\\\\\\"\\ \\\\u003e\\\\u003econfig.txt\\\\n\\ \\ echo\\ \\\\\\\"q1\\=\\\\\\\"\\$read_1_path\\ \\\\u003e\\\\u003econfig.txt\\\\n\\ \\ echo\\ \\\\\\\"q2\\=\\\\\\\"\\$read_2_path\\ \\\\u003e\\\\u003econfig.txt\\\\nfi\\\\n\\\\n\\#SOAPdenovo\\ main\\ program\\\\n/usr/bin/SOAPdenovo-63mer\\ all\\ -s\\ config.txt\\ -K\\ \\$k_mer\\ -R\\ -p\\ \\$\\(nproc\\)\\ -o\\ \\\\\\\"\\$prefix\\\\\\\"\\ \\\\n\\\\n\\#result\\ outputs\\\\nemit\\ contig_output\\ \\\\\\\"\\$prefix\\\\\\\".contig\\\\nemit\\ scaffold_output\\ \\\\\\\"\\$prefix\\\\\\\".scaf\\\\ntar\\ -cf\\ \\\\\\\"\\$prefix\\\\\\\".tar\\ \\\\\\\"\\$prefix\\\\\\\"\\*.\\*\\\\ngzip\\ \\\\\\\"\\$prefix\\\\\\\".tar\\\\nemit\\ all_result\\ \\\\\\\"\\$prefix\\\\\\\".tar.gz\\\"\\} | python -c 'import sys,json; print json.load(sys.stdin)[\"code\"]' \u003e /script.sh"]

# Create directory /work and set it to $HOME and CWD
RUN mkdir -p /work
ENV HOME="/work"
WORKDIR /work

# Set entry point to container
ENTRYPOINT ["/usr/bin/run"]

VOLUME /data
VOLUME /work