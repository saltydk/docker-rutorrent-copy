<?php
	// configuration parameters

	// for snoopy client
	$httpUserAgent = 'Mozilla/5.0 (Windows NT 6.0; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0';
	$httpTimeOut = 30;
	$httpUseGzip = true;

	// for xmlrpc actions
	$rpcTimeOut = 5;
	$rpcLogCalls = false;
	$rpcLogFaults = true;

	// for php
	$phpUseGzip = false;
	$phpGzipLevel = 2;
	// rand for schedulers start, +0..X seconds
	$schedule_rand = 10;

	// Path to log file (comment or leave blank to disable logging)
	$log_file = '/config/log/rutorrent/rutorrent.log';
	$do_diagnostic = true;

	// Set to true if rTorrent is hosted on the SAME machine as ruTorrent
	$localHostedMode = true;

	// Set to true to enable rapid cached loading of ruTorrent plugins
	// Required to clear web browser cache during version upgrades
	$cachedPluginLoading = false;
	
	// Save uploaded torrents to profile/torrents directory or not
	$saveUploadedTorrents = true;
	
	// Overwrite existing uploaded torrents in profile/torrents directory or make unique name
	$overwriteUploadedTorrents = false;
	
	// Upper available directory. Absolute path with trail slash.
	$topDirectory = '/';
	$forbidUserSettings = false;
	
	// For web->rtorrent link through unix domain socket
	$scgi_port = 0;
	$scgi_host = "unix:////run/php/.rtorrent.sock";
	$XMLRPCMountPoint = "/RPC2";
	$throttleMaxSpeed = 327625*1024;
	
	$pathToExternals = array(
	    "php"    => '/usr/bin/php',
	    "curl"   => '/usr/bin/curl',
	    "gzip"   => '/usr/bin/gzip',
	    "id"     => '/usr/bin/id',
	    "stat"   => '/bin/stat',
	    "python" => '/usr/bin/python3',
	);
	
	// List of local interfaces
	$localhosts = array(
	    "127.0.0.1",
	    "localhost",
	);
	
	// Path to user profiles
	$profilePath = '/config/rutorrent/profiles';
	// Mask for files and directory creation in user profiles.
	$profileMask = 0777;
	
	// Temp directory. Absolute path with trail slash. If null, then autodetect will be used.
	$tempDirectory = '/config/rutorrent/profiles/tmp/';
	
	// If true then use X-Sendfile feature if it exist
	$canUseXSendFile = true;
	
	$locale = 'UTF8';
	
	$enableCSRFCheck = false; // If true then Origin and Referer will be checked
	$enabledOrigins = array(); // List of enabled domains for CSRF check (only hostnames, without protocols, port etc.). If empty, then will retrieve domain from HTTP_HOST / HTTP_X_FORWARDED_HOST
