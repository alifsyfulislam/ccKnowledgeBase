<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
//use Illuminate\Database\Eloquent\Relations\BelongsTo;
//use Illuminate\Database\Eloquent\Relations\HasMany;

class Category extends Model
{
    /**
     * @var string[]
     */
    protected $fillable = ['title','parent_id', 'slug'];


    /**
     * @return HasMany
     */
    public function children()
    {
        return $this->hasMany('App\Models\Category', 'parent_id');
    }

    /**
     * @return HasMany
     */
    public function childrenRecursive()
    {
        return $this->children()->with('childrenRecursive');

    }

    /**
     * @return BelongsTo
     */
    public function parent()
    {
        return $this->belongsTo('App\Models\Category','parent_id');
    }


    /**
     * @return BelongsTo
     */
    public function parentRecursive()
    {
        return $this->parent()->with('parentRecursive');
    }


    public function article()
    {

        return $this->hasMany(Article::class);

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
