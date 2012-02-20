This is source code of [Ruby China Group](http://ruby-china.org)

## Install

  * You need to install *Ruby 1.9.2*, *Rubygems* and *Rails 3.1* first.
  * Install *Redis*, *MongoDB*, *memcached*, *Python*, *Pygments*

## Run Servers

  * Start Redis: run redis-server
  * Start memcached: run memcached
  * Start MongoDB server: run mongod (must be **superuser**)

## Setup Configure

  Modify config/thin.yml

  ```
  #chdir: /home/ruby/www/ruby-china/current
  ```

  change to your path. If you only wanted to test on your own computer, just comment this line.

  ```
  cp config/config.yml.default config/config.yml
  cp config/mongoid.yml.default config/mongoid.yml
  cp config/redis.yml.default config/redis.yml
  bundle install
  bundle update rails
  rake assets:precompile
  thin start -O -C config/thin.yml
  ./script/resque start
  bundle exec rake sunspot:solr:start
  easy_install pygments # 或者 pip install pygments
  rake db:migrate
  ```

## Deploy

  ```
  $ cap deploy
  $ cap production remote_rake:invoke task=db:setup
  ```


  Or if you want to just test on your own computer, run:

  ```
  $ script/rails s
  ```

  Open your brower, visit http://0.0.0.0:3000

## OAuth

* be sure to use: http://ruby-china.dev/
* callback url: http://ruby-china.dev/account/auth/github/callback

# Apply Google JSAPI

* http://code.google.com/intl/zh-CN/apis/loader/signup.html

## 麵包屑

### in controller

    drop_breadcrumb("A Level")
    drop_breadcrumb("B Level")

## Menu

    render_list :class => "menu" do |li|
      li << link_to("Home", "/")
    end

## Bootstrap CSS version

1.4.0

## Bootstrap Form

<https://github.com/rafaelfranca/simple_form-bootstrap/blob/master/config/initializers/simple_form.rb>

## Memcached

Dalli requires memcached 1.4.x +

## Helpers

    render_topic_title(topic)

## Common Partial

* common/user\_nav : user\_navigation_bar

## Facebook Share

facekbook_enable: false by default

## Styling Guide

* Don't put plain html in helper
* NEVER LOGIC in View
* 重複用到的方法請隨手用 Helper 包
* 永遠使用括號 () 包覆複雜 Helper

## Contributors

* [Contributors](https://github.com/huacnlee/ruby-china/contributors)

## Thanks

* [Twitter Bootstrap](https://twitter.github.com/bootstrap)

Forked from [Homeland Project](https://github.com/huacnlee/homeland)
