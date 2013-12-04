package App::ZofCMS::Plugin::HTMLFactory::Entry;

use warnings;
use strict;

our $VERSION = '0.0101';

sub new { bless {}, shift }

sub process {
    my ( $self, $template ) = @_;
    $template->{t}{entry_start} = <<"END";
<div class="entry">
    <div class="entry_top">
        <div class="entry_bottom">
END
    $template->{t}{entry_end} = <<"END";
        </div>
    </div>
</div>
END
}

1;
__END__

=head1 NAME

App::ZofCMS::Plugin::HTMLFactory::Entry - plugin to wrap content in three divs used for styling boxes

=head1 SYNOPSIS

In your Main Config File or ZofCMS Template file:

    plugins => [ qw/HTMLFactory::Entry/ ],

In your L<HTML::Template> template:

    <tmpl_var name='entry_start'>
        <p>Some content</p>
    <tmpl_var name='entry_end'>

=head1 DESCRIPTION

The module is a plugin for L<App::ZofCMS>. The module resides in
C<App::ZofCMS::Plugin::HTMLFactory::> namespace thus only provides some packed HTML code.

I use the HTML code provided by the plugin virtually on every site, and am sick and tired of
writing it! Hence the plugin.

This documentation assumes you've read L<App::ZofCMS>, L<App::ZofCMS::Config> and L<App::ZofCMS::Template>

=head1 MAIN CONFIG FILE AND ZofCMS TEMPLATE FIRST-LEVEL KEYS

=head2 C<plugins>

    plugins => [ qw/HTMLFactory::Entry/ ],

To run the plugin all you have to do is include it in the list of plugins to execute.

=head1 HTML::Template VARIABLES

    <tmpl_var name='entry_start'>
    <tmpl_var name='entry_end'>

The plugins creates two keys in C<{t}> ZofCMS Template special keys.

=head2 C<entry_start>

    <tmpl_var name='entry_start'>

The C<entry_start> will be replaced with the following HTML code:

    <div class="entry">
        <div class="entry_top">
            <div class="entry_bottom">

=head2 C<entry_end>

    <tmpl_var name='entry_end'>

The C<entry_end> will be replaced with the following HTML code:

            </div>
        </div>
    </div>

=head1 AUTHOR

'Zoffix, C<< <'zoffix at cpan.org'> >>
(L<http://zoffix.com/>, L<http://haslayout.net/>, L<http://zofdesign.com/>)

=head1 BUGS

Please report any bugs or feature requests to C<bug-app-zofcms-plugin-htmlfactory-entry at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-ZofCMS-Plugin-HTMLFactory-Entry>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::ZofCMS::Plugin::HTMLFactory::Entry

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-ZofCMS-Plugin-HTMLFactory-Entry>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/App-ZofCMS-Plugin-HTMLFactory-Entry>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/App-ZofCMS-Plugin-HTMLFactory-Entry>

=item * Search CPAN

L<http://search.cpan.org/dist/App-ZofCMS-Plugin-HTMLFactory-Entry>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2008 'Zoffix, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

