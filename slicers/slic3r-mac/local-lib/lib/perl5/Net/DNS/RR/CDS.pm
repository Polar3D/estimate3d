package Net::DNS::RR::CDS;

#
# $Id: CDS.pm 1526 2017-01-16 09:17:54Z willem $
#
our $VERSION = (qw$LastChangedRevision: 1526 $)[1];


use strict;
use warnings;
use base qw(Net::DNS::RR::DS);

=head1 NAME

Net::DNS::RR::CDS - DNS CDS resource record

=cut


use integer;


sub _encode_rdata {			## encode rdata as wire-format octet string
	my $self = shift;

	return $self->SUPER::_encode_rdata() if $self->{algorithm};
	return defined $self->{algorithm} ? pack 'x4' : '';
}


sub _format_rdata {			## format rdata portion of RR string.
	my $self = shift;

	return $self->SUPER::_format_rdata() if $self->{algorithm};
	return defined $self->{algorithm} ? '0 0 0 0' : '';
}


sub algorithm {
	my ( $self, $arg ) = @_;

	return $self->{algorithm} unless defined $arg;
	return Net::DNS::RR::DS::_algbyval( $self->{algorithm} ) if uc($arg) eq 'MNEMONIC';
	my $val = Net::DNS::RR::DS::_algbyname($arg);
	@{$self}{qw(keytag digtype digestbin)} = ( 0, 0, '' ) unless $val;
	return $self->{algorithm} = $val;
}


sub digtype {
	my ( $self, $arg ) = @_;

	return $self->{digtype} unless defined $arg;
	return Net::DNS::RR::DS::_digestbyval( $self->{digtype} ) if uc($arg) eq 'MNEMONIC';
	return $self->{digtype} = Net::DNS::RR::DS::_digestbyname($arg);
}


1;
__END__


=head1 SYNOPSIS

    use Net::DNS;
    $rr = new Net::DNS::RR('name CDS keytag algorithm digtype digest');

=head1 DESCRIPTION

DNS Child DS resource record

This is a clone of the DS record and inherits all properties of
the Net::DNS::RR::DS class.

Please see the L<Net::DNS::RR::DS> perl documentation for details.

=head1 METHODS

The available methods are those inherited from the base class augmented
by the type-specific methods defined in this package.

Use of undocumented package features or direct access to internal data
structures is discouraged and could result in program termination or
other unpredictable behaviour.



=head1 COPYRIGHT

Copyright (c)2014,2017 Dick Franks

All rights reserved.

Package template (c)2009,2012 O.M.Kolkman and R.W.Franks.


=head1 LICENSE

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted, provided
that the above copyright notice appear in all copies and that both that
copyright notice and this permission notice appear in supporting
documentation, and that the name of the author not be used in advertising
or publicity pertaining to distribution of the software without specific
prior written permission.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.


=head1 SEE ALSO

L<perl>, L<Net::DNS>, L<Net::DNS::RR>, L<Net::DNS::RR::DS>, RFC7344

=cut
