<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Faq extends Model
{
    protected $fillable = [
        'id', 'user_id', 'category_id', 'en_title', 'bn_title', 'tag', 'slug', 'en_body', 'status', 'publish_date'
    ];
}
