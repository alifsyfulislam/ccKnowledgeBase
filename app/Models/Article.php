<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

class Article extends Model
{
    protected $fillable = [
        'id', 'user_id', 'category_id', 'en_title', 'bn_title', 'tag', 'slug', 'en_short_summary', 'bn_short_summary', 'en_body', 'bn_body', 'status', 'publish_date'
    ];

    /*public function media()
    {
        return $this->morphMany(Media::class, 'mediable');
    }*/

    public function user()
    {

        return $this->belongsTo(User::class);

    }

    public function category()
    {

        return $this->belongsTo(Category::class);

    }

    public function getCreatedAtAttribute($date)
    {
        return Carbon::createFromFormat('Y-m-d H:i:s', $date)->format("F j, Y, g:i a");
    }

    public function getUpdatedAtAttribute($date)
    {
        return Carbon::createFromFormat('Y-m-d H:i:s', $date)->format("F j, Y, g:i a");
    }
}
