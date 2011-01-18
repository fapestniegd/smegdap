package smegdap;

use strict;
use warnings;

use Catalyst::Runtime '5.70';
use YAML qw(LoadFile);
use Path::Class 'file';

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root 
#                 directory

use parent qw/Catalyst/;
use Catalyst qw/-Debug ConfigLoader Authentication Authorization::Roles Static::Simple Session Session::Store::FastMmap Session::State::Cookie/;
our $VERSION = '0.01';

# Configure the application. 
#
# Note that settings in smegdap.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with a external configuration file acting as an override for
# local deployment.

__PACKAGE__->config( name => 'smegdap' );
__PACKAGE__->config->{'authentication'} = ( YAML::LoadFile( file(__PACKAGE__->config->{home}, 'authconfig.yaml') ) );
# Start the application
__PACKAGE__->setup( qw/RequireSSL/ );
__PACKAGE__->config->{require_ssl} = { remain_in_ssl => 1, no_cache => 1, };

# Start the application
__PACKAGE__->setup();


=head1 NAME

smegdap - Catalyst based application

=head1 SYNOPSIS

    script/smegdap_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<smegdap::Controller::Root>, L<Catalyst>

=head1 AUTHOR

James White

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
