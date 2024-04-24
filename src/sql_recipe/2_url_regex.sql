SELECT
    stamp,
    substring(referrer from 'https?://([^/]*)') AS referrer_host 
    from access_log;