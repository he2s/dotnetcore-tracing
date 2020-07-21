FROM mcr.microsoft.com/dotnet/core/sdk:3.1

WORKDIR /work

ENV PATH "$PATH:/root/.dotnet/tools"

RUN dotnet tool install --global dotnet-trace \
	&& dotnet tool install --global dotnet-dump \
	&& dotnet tool install --global dotnet-counters \
	&& dotnet tool install --global dotnet-gcdump \
	&& dotnet tool install -g dotnet-sos \
	&& dotnet-sos install

RUN apt-get -y update && apt-get -y install tmux zsh git vim fish tcpdump glances \
	lldb tiptop autoconf gcc g++ build-essential \
	&& apt-get -y autoremove && apt-get -y clean



RUN git clone https://github.com/hishamhm/htop && cd htop && git checkout 3.0.0beta5 && ./autogen.sh && ./configure && make && cp -a htop /usr/bin/

