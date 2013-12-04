package App::ZofCMS::Plugin::Tutor;

use strict;
use warnings;
use base 'App::ZofCMS::Plugin::Base';
use DBI;
use HTML::Entities;

use Data::Dumper;

sub _key { 'plug_tutor' }
sub _defaults {
    return (
#         dsn  =>
        user => '',
        pass => undef,
        opt => { RaiseError => 1, AutoCommit => 1 },
        create_tables => 0,
        table_prefix    => 'tutor_',
#         user_id         => sub { shift->{d}{user}{id} },
#         run_tutorial    => [qw/add delete send_email/],
    );
}
sub _do {
    my ( $self, $conf, $t, $q, $config ) = @_;

    @$self{qw/CONF  T  Q/} = ( $conf, $t, $q );

    return unless $conf->{run_tutorial};
    $conf->{run_tutorial} = [ $conf->{run_tutorial} ]
        unless ref $conf->{run_tutorial};

    $conf->{create_tables} and $self->_create_tables( $conf );

    $self->_add_new_step if $q->{tutor_add_new};

    $t->{t}{tutor_admin} = $self->_prepare_admin;
}

sub _add_new_step {
    my $self = shift;

}

sub _prepare_admin {
    my $self = shift;

    my $form_t = HTML::Template->new_scalar_ref(
        \ _get_admin_form_template(),
        die_on_bad_params => 0,
    );

    my $q = $self->{Q};
    $form_t->param(
        page          => $q->{dir} . $q->{page},
        taf_tutorial  => $q->{tutorial}  // '',
        taf_step      => $q->{step}      // '',
        taf_step_text => $q->{step_text} // '',
    );

    return $form_t->output;
}

sub _create_tables {
    my $self = shift;
    my $conf = shift;
    my $dbh = $self->_dbh;

    $dbh->do(
        "CREATE TABLE `$conf->{table_prefix}tutorials` (
            `id`        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            `name`      TEXT,
            `class_prefix` TEXT
        );",
    );

    $dbh->do(
        "CREATE TABLE `$conf->{table_prefix}pupils` (
            `user_id`           INT UNSIGNED,
            `tutorial_id`       INT UNSIGNED,
            PRIMARY KEY (`user_id`, `tutorial_id`)
        );",
    );

    $dbh->do(
        "CREATE TABLE `$conf->{table_prefix}tutorial_steps` (
            `id`                INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            `tutorial_id`       INT UNSIGNED,
            `step`              INT UNSIGNED,
            `step_text`         TEXT
        );",
    );
}

sub _get_admin_form_template {
    return <<'END_HTML';
<tmpl_if name='added_ok'>
    <p class="message-success">Successfully added tutorial step.</p>
</tmpl_if>

<form action="" method="POST" id="tutor_admin_form">
<div>
    <input type="hidden" name="page" value="<tmpl_var escape='html' name='page'>">
    <input type="hidden" name="tutor_add_new" value="1">
    <ul>
        <li>
            <label for="taf_tutorial">Tutorial:</label
            ><input type="text"
                class="input_text"
                id="taf_tutorial"
                name="tutorial"
                value="<tmpl_var escape='html' name='taf_tutorial'>">
        </li>
        <li>
            <label for="taf_step">Step #:</label
            ><input type="text"
                class="input_text"
                id="taf_step"
                name="step"
                value="<tmpl_var escape='html' name='taf_step'>">
        </li>
        <li>
            <label for="taf_step_text" class="textarea_label">Step text:</label
            ><textarea id="taf_step_text"
                name="step_text"
                cols="70" rows="4"><tmpl_var escape='html' name='taf_step_text'></textarea>
        </li>
    </ul>
    <input type="submit" class="input_submit" value="Add step">
</div>
</form>
END_HTML
}

1;
__END__


CREATE TABLE `tutor_tutorials` (
    `id`        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `name`      TEXT,
    `class_prefix` TEXT
);

CREATE TABLE `tutor_pupils` (
    `user_id`           INT UNSIGNED,
    `tutorial_id`       INT UNSIGNED,
    PRIMARY KEY (`user_id`, `tutorial_id`)
);

CREATE TABLE `tutor_tutorial_steps` (
    `id`                INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `tutorial_id`       INT UNSIGNED,
    `order`             INT UNSIGNED,
    `step`              TEXT
);




