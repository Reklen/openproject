#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2014 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See doc/COPYRIGHT.rdoc for more details.
#++

require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'api/v3/groups/index.api.rabl' do
  before do
    params[:format] = 'json'

    assign(:groups, groups)
    render
  end

  subject { response.body }

  describe 'with no groups available' do
    let(:groups) { [] }

    it { should have_json_path('groups') }
    it { should have_json_size(0).at_path('groups') }
  end

  describe 'with 2 groups available' do
    let(:groups) { [
      FactoryGirl.build(:group), FactoryGirl.build(:group)
    ] }

    it { should have_json_path('groups') }
    it { should have_json_size(2).at_path('groups') }

    it { should have_json_type(Object).at_path('groups/1')  }
    it { should have_json_path('groups/1/name')             }
  end
end
