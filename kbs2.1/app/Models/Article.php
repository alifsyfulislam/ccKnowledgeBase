<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;

class Article extends Model
{
    /**
     * @var string[]
     */
    protected $fillable = [
        'id', 'user_id', 'category_id', 'en_title', 'bn_title', 'tag', 'slug', 'en_short_summary', 'bn_short_summary', 'en_body', 'bn_body', 'status', 'publish_date'
    ];

    /*public function media()
    {
        return $this->morphMany(Media::class, 'mediable');
    }*/

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user()
    {

        return $this->belongsTo(User::class);

    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function category()
    {

        return $this->belongsTo(Category::class);

    }

    /**
     * @param $date
     * @return string
     */
    public function getCreatedAtAttribute($date)
    {

        return date('j M, Y', strtotime($date));

    }

    /**
     * @param $date
     * @return string
     */
    public function getUpdatedAtAttribute($date)
    {

        return date('j M, Y', strtotime($date));

    }
}