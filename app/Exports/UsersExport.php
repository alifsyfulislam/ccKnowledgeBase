<?php

namespace App\Exports;

use App\Models\User;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\Exportable;
use Maatwebsite\Excel\Concerns\FromArray;
use Maatwebsite\Excel\Concerns\FromQuery;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\FromCollection;
use App\Http\Traits\QueryTrait;


class UsersExport implements FromArray, WithMapping, WithHeadings
{
    use Exportable;

    protected $ibUserDataCollection;

    public function __construct($query = null)
    {
        $this->ibUserDataCollection = $query;
    }

    public function headings(): array
    {
        return [
            "id",
            "username",
            "First Name",
            "Last Name",
            "Email",
            "Created At",
            "Updated At",
            "Role Name"
        ];
    }

    public function map($user) : array
    {
        return [
            $user->id,
            $user->username,
            $user->first_name,
            $user->last_name,
            $user->email,
            Carbon::parse($user->created_at)->toFormattedDateString(),
            Carbon::parse($user->updated_at)->toFormattedDateString(),
            //$user->email,
            //array_key_exists( $user->roles, 0) ?? false
            $user->roles ? $user->roles->name : 'N/A',
           // $user->created_at,
        ];
    }

    public function array() : array
    {
        return $this->ibUserDataCollection;
    }

}
