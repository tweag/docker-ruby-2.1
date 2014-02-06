FROM centos
MAINTAINER PromptWorks <team@promptworks.com>

RUN export RUBY_INSTALL_VERSION=0.3.4 && \
    export RUBY_VERSION=2.1.0 && \
    cd /tmp && \
    yum list installed | cut -f 1 -d " " | uniq | sort > /tmp/pre && \
    yum install git -y && \
    wget -O ruby-install-$RUBY_INSTALL_VERSION.tar.gz \
      https://github.com/postmodern/ruby-install/archive/v$RUBY_INSTALL_VERSION.tar.gz && \
    tar -xzf ruby-install-$RUBY_INSTALL_VERSION.tar.gz && \
    cd ruby-install-$RUBY_INSTALL_VERSION && \
    make install && \
    ruby-install -i /usr/local ruby $RUBY_VERSION && \
    make uninstall && \
    yum list installed | cut -f 1 -d " " | uniq | sort > /tmp/post && \
    diff /tmp/pre /tmp/post | grep "^>" | cut -f 2 -d ' ' | \
      xargs echo yum erase -y && \
    yum clean all && \
    rm -rf /usr/local/src/ruby* && \
    rm -rf /tmp/*

RUN gem update --system --no-document
RUN gem install bundler --no-ri --no-rdoc
