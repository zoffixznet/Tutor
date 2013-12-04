#!/usr/bin/env perl

use strict;
use warnings;

use lib qw(../zcms_site ../zcms_site/CPAN);
use App::ZofCMS::Config;
use App::ZofCMS::Template;
use App::ZofCMS::Output;

use CGI::Carp qw/fatalsToBrowser/;

my $config = App::ZofCMS::Config->new;

my $conf = $config->load( '../zcms_site/config.txt' );

my $template;

RELOADS: {
    $template = App::ZofCMS::Template->new( $config );

    $template->load;
    $template->prepare_defaults;
    $template->execute_before;
    $template->assemble;
    $template->execute
        or redo RELOADS;
}

my $output = App::ZofCMS::Output->new( $config, $template );
print $output->headers;
print $output->output;
exit;
