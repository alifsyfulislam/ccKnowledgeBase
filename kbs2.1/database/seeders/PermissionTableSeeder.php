<?php
namespace Database\Seeders;

use App\Helpers\Helper;
use App\Models\Permission;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Schema;

class PermissionTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Schema::disableForeignKeyConstraints();
        Permission::truncate();

        $Permissions = [
            'User List',
            'User Create',
            'User Edit',
            'User Delete',
            'Role List',
            'Role Create',
            'Role Edit',
            'Role Delete',
            'Permission List',
            'Permission Create',
            'Permission Edit',
            'Permission Delete',

            'History List',

            'Category List',
            'Category Create',
            'Category Edit',
            'Category Delete',

            'Article List',
            'Article Create',
            'Article Edit',
            'Article Delete',

            'Faq List',
            'Faq Create',
            'Faq Edit',
            'Faq Delete',

            'Quiz List',
            'Quiz Create',
            'Quiz Edit',
            'Quiz Delete',

            'Quiz Form List',
            'Quiz Form Create',
            'Quiz Form Edit',
            'Quiz Form Delete',

            'Quiz Form Field List',
            'Quiz Form Field Create',
            'Quiz Form Field Edit',
            'Quiz Form Field Delete',

            'Page List',
            'Page Create',
            'Page Edit',
            'Page Delete',

            'Banner Create',
            'Banner List',
            'Banner Edit',
            'Banner Delete',


            'Comment Create',
            'Comment List',
            'Comment Edit',
            'Comment Delete',

            'Email List',
            'Email Create',
            'Email Edit',
            'Email Delete',

            'Notification List',
            'Notification Create',
            'Notification Edit',
            'Notification Delete',

            'Admin Panel'
        ];


        foreach ($Permissions as $Permission) {

             Permission::Create(['name' => $Permission, 'slug' => Helper::slugify($Permission)]);
//            DB::collection('permission')->create(['name' => $Permission, 'slug' => Helper::slugify($Permission)]);

        }

        Schema::enableForeignKeyConstraints();
    }
}
