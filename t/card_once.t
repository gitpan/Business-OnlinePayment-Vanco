#!/usr/bin/perl -w

use Test::More;
require "t/lib/test_account.pl";

my($login, $password, @opts) = test_account_or_skip();
plan tests => 2;
  
use_ok 'Business::OnlinePayment';

my $tx = Business::OnlinePayment->new("Vanco", @opts);
$tx->content(
    type           => 'VISA',
    login          => $login,
    password       => $password,
    action         => 'Normal Authorization',
    description    => 'Business::OnlinePayment visa test',
    amount         => '49.95',
    customer_id    => 'tfb',
    name           => 'Tofu Beast',
    address        => '123 Anystreet',
    city           => 'Anywhere',
    state          => 'UT',
    zip            => '84058',
#    card_number    => '4007000000027',
    card_number    => '4111111111111111',
    expiration     => expiration_date(),
);
$tx->test_transaction(1); # test, dont really charge
$tx->submit();

ok($tx->is_success()) or diag $tx->error_message;
