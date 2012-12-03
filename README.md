attempt_to
==========

Small gem for attempting to do something and returning errors if it fails.

Usage:

# Try to connect 3 times to the network, otherwise exit.
attempt_to('connect to the network', 3) {
	TCPSocket.new("some.very.weird.domain.name", 9342)
}
